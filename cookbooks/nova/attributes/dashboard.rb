default[:nova][:dashboard][:admin_email] = "admin@example.com"
default[:nova][:dashboard][:admin_user] = "admin"
default[:nova][:dashboard][:admin_password] = "sha1$4361c$4d5e785f6e18734ae843c10dcb30104bafacf21d" # "vagrant"
default[:nova][:dashboard][:deploy_dir] = "/srv/dashboard"
default[:nova][:dashboard][:dashboard_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "openstack-dashboard")
default[:nova][:dashboard][:dashboard_branch] = "lp:openstack-dashboard"
default[:nova][:dashboard][:django_nova_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "django-nova")
default[:nova][:dashboard][:django_nova_branch] = "lp:django-nova"
default[:nova][:dashboard][:apache_dir] = "/etc/apache2"
default[:nova][:dashboard][:database_name] = "dashboard.db"
default[:nova][:dashboard][:default_region] = "nova"
