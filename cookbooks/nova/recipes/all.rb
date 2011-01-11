#
# Cookbook Name:: nova
# Recipe:: all
#
# Copyright 2011, Anso Labs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

package "nova-common" do
  options "--force-yes -o Dpkg::Options::=\"--force-confdef\""
  action :install
end

directory "/etc/nova" do
    owner "root"
    group "root"
    mode 0755
    action :create
end

template "/etc/nova/nova.conf" do
  source "nova.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

%w{nova-compute nova-api nova-objectstore nova-scheduler nova-network nova-volume}.each do |pkg|
  package pkg do
    options "--force-yes"
    action :install
  end

  service pkg do
    if (platform?("ubuntu") && node.platform_version.to_f >= 10.04)
      restart_command "restart #{pkg}"
      stop_command "stop #{pkg}"
      start_command "start #{pkg}"
      status_command "status #{pkg}"
    end
    supports :status => true, :restart => true, :reload => true
    action :nothing
    subscribes :restart, resources(:template => "/etc/nova/nova.conf")
  end
end


service "iscsitarget" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

file "/etc/default/iscsitarget" do
  content <<-EOH
ISCSITARGET_ENABLE=true
  EOH
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "iscsitarget"), :immediately
end
