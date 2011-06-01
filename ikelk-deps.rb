dep 'sudo.managed'
dep 'ntpdate.managed'
dep 'sysv-rc-conf.managed'
dep 'ruby.managed'
dep 'postfix.managed'
dep 'percona-server.managed'
dep 'nginx.managed'
dep 'syslog-ng.managed'
dep 'imagemagick.managed'
# dep 'python-setuptools' ? pip?
dep 'collected-core.managed'
dep 'curl.managed'
dep 'zlib1g-dev.managed'
dep 'libssl-dev.managed'
dep 'libreadline5-dev.managed'
#dep 'xtrabackup.managed'
dep 'tmux.managed'
dep 'htop.managed'
dep 'monit.managed'
dep 'logrotate.managed'
dep 'collectd-utils.managed'
dep 'librrdtool-oo-perl.managed'
dep 'libjson-perl.managed'
dep 'liburi-perl.managed'
dep 'libwww-perl.managed'
dep 'mc.managed'
dep 'vim.managed'

dep 'percona-server.managed' do
  requires 'percona key added to apt', 'percona apt repository', 'percona-server-server-5.5.managed'
  provides 'mysql'
end

dep 'percona-server-server-5.5.managed'

dep 'percona key added to apt' do
  met? { !sudo('apt-key list | grep Percona').blank? }
  meet { sudo('apt-key adv --keyserver keys.gnupg.net --recv CD2EFD2A') }
end

dep 'percona apt repository' do
  setup {
    set :codename, Babushka::Base.host.get_version_info.val_for('Codename')
  }

  met? { grep /repo\.percona\.com/, '/etc/apt/sources.list' }
  meet { append_to_file "deb http://repo.percona.com/apt #{var(:codename)}", Fancypath.new("/etc/apt/sources.list"), :sudo => true }
  after { Babushka::Base.host.pkg_helper.update_pkg_lists }
end

# install pip
# install pygments
#
# adduser ikelk
#
# add rvm for ikelk
#
# configure postfix
#
# configure ssh
#
# configure logrotate
#
# configure cron
#
# configure monit
#
# configure ntpdate
#
# configure sysv
#
# configure mysql
#
# configure collectd
#
# configure nginx
#
# configure apparmor
#
# generate ssh keys for ikelk
