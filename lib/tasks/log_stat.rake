namespace :log_stat do
  desc "Re-create the log stats"
  task :create => :environment do
    puts '== Drop all stats =='
    LogStat.delete_all

    puts '== Collecting stats =='
    Channel.all.each do |channel|
      channel.messages.group_by_day(:created_at).count.each do |date, count|
        next if 0 == count
        LogStat.create(channel_id: channel.id, date: date)
      end
    end

    puts 'Log stat created successfully'
  end
end
