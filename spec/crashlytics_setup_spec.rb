require 'spec_helper'
require 'highline/import'
require 'highline/simulate'

describe Liftoff::CrashlyticsSetup do
  describe '#crashlytics_setup' do
    let(:response) { double('Response', :success? => true, :body => {organizations: [{name: 'xxx', api_key: 'yyy'}]}.to_json) }
    
    it 'returns crashlytics developer key' do
      hash = SecureRandom.hex(20)
      
      allow(subject).to receive(:`).with(/mdfind/) {"/Applications/Crashlytics.app"}
      allow(File).to receive(:"file?").and_return(true)
      allow(subject).to receive(:`).with(/strings/) {"xxx\nfff\n#{hash}\nfds"}
      
      expect(subject.send(:init_crashlytics)).to eq(hash)
    end
    
    it 'fails when there is no crashlytics app installed' do
      allow(subject).to receive(:`).with(/mdfind/) {""}
      
      expect{subject.send(:init_crashlytics)}.to raise_exception
    end
    
    it 'fails when crashlytics app is corrupted' do
      allow(subject).to receive(:`).with(/mdfind/) {"/Applications/Crashlytics.app"}
      allow(File).to receive(:"file?").and_return(false, false)
      
      expect{subject.send(:init_crashlytics)}.to raise_exception
    end
    
    it 'fails when can''t find developer key' do
      allow(subject).to receive(:`).with(/mdfind/) {"/Applications/Crashlytics.app"}
      allow(File).to receive(:exists?).and_return(true)
      allow(subject).to receive(:`).with(/strings/) {"xxx\nfff\n\nfds"}
      
      expect{subject.send(:init_crashlytics)}.to raise_exception
    end
    
    it 'should fetch organizations from api' do
      HTTParty.should_receive(:post).and_return(response)
      
      organizations = subject.send(:get_organizations)
      
      expect(organizations).to eq({'xxx' => 'yyy'})
    end
    
    it 'expects to user pick organization' do
      organization = nil
      HighLine::Simulate.with("1\n") do
        organization = subject.send(:pick_organization, {'xxx' => 'yyy'})
      end
      expect(organization).to eq({'xxx' => 'yyy'})
    end
  end
end
