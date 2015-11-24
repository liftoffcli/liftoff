#!/usr/bin/env bash

<% if dependency_manager_enabled?("bundler") %>
bundle install
<% end %>
<% if enable_settings && dependency_manager_enabled?("cocoapods") %>
pod install
<% end %>
<% if dependency_manager_enabled?("carthage") %>
carthage update
<% end %>
