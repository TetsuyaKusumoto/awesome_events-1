# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'awesome_events'
set :repo_url, 'git@github.com:tetsuyakusumoto/awesome_events-1.git'

set :deploy_to, '/var/www/awesome-events'
set :scm, :git

set :keep_releases, 5

# rbenvの設定
set :rbenv_type, :system    # rbenv_custom_pathを指定していれば不要
set :rbenv_ruby, '2.2.2'    # rubyのバージョン（事前に指定バージョンをインストールしておく必要あり。）
set :rbenv_custom_path, '/home/vagrant/.rbenv'    # rbenvのインストール先
set :rbenv_map_bins, %w{rake gem bundle ruby rails} # rbenv execをつけたいコマンド

set :default_env, {
  rbenv_root: "/home/vagrant/.rbenv/bin/rbenv",
  path: "/home/vagrant/.rbenv/shims/home/vagrant/.rbenv/bin/:$PATH:"
#  rbenv_root: "/usr/local/rbenv",
#  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :linked_dirs, (fetch(:linked_dirs) + ['tmp/pids'])

set :unicorn_rack_env, "none"
set :unicorn_config_path, 'config/unicorn.rb'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

set :ssh_options, {
  user: 'tetsuyakusumoto',
  keys: %w{~/.ssh/id_rsa},
  forward_agent: true,
  auth_methods: %w{publickey}
}
