maintainer       "SecondMarket Labs, LLC"
maintainer_email "systems@secondmarket.com"
license          "Apache 2.0"
description      "Installs/Configures graphite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{redhat centos fedora}.each do |os|
	supports os
end

%w{python rhapache}.each do |p|
	depends p
end

suggests "graphiti"
