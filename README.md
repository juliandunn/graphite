Description
===========

Installs and configures Graphite (http://graphite.readthedocs.org)

Requirements
============

* CentOS 6
* Red Hat Enterprise Linux 6
* Fedora

Note: CentOS/RHEL 5 is too old to run Graphite on. In particular, its lack of
sufficiently new Twisted libraries hinders it.

Attributes
==========

* `node[:graphite][:server][:password]` sets the default password for the
   graphite "root" user.
* `node[:graphite][:web][:virtualhostname]` sets the virtual host name under
   which you are running the Graphite Composer and render API.

Usage
=====

`recipe[graphite::server]` should build a stand-alone Graphite installation.

Caveats
=======

Ships with two default schemas, stats.* (for Etsy's statsd) and a
catchall that matches anything. The catchall retains minutely data for
13 months, as in the default config. stats retains data every 10 seconds
for 6 hours, every minute for a week, and every 10 minutes for 5 years.

Todo
====

Fix test_kitchen support (not sure that the tests actually work)

Credits
=======

Forked from Heavy Water Software: https://github.com/heavywater/chef-graphite
