Rake::Task['deploy:new_release_path'].clear

namespace :deploy do
  desc 'new release path to JST'
  task :new_release_path do
    set_release_path(Time.now.strftime('%Y%m%d%H%M%S'))
  end
  namespace :sample do
    desc 'create symlinks'
    task :create_symlinks do
      targets = fetch(:symlinks)
      targets.each do | val |
        on roles(val[:role]), in: :sequence, wait: 2 do
          val[:targets].each do | target |
            execute :sudo, "ln -fns #{release_path.join( target[:from])} #{target[:to]}"
          end
        end
      end
    end
  end
end
