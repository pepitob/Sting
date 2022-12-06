namespace :wp do
  desc "Inizialize all weekly progresses for challenges starting today"
  task initialize: :environment do
    Challenge.all.each do |challenge|
      if (challenge.start_date >= Date.today) && (Date.today <= challenge.end_date)
        if ((Date.today - challenge.start_date) % 7).zero? && (Date.today - challenge.start_date) >= 0
          challenge.participations.each do |participation|
            weekly_progress = WeeklyProgress.new
            week = ((Date.today - challenge.start_date).to_i / 7) + 1
            weekly_progress.user = participation.user
            weekly_progress.challenge = challenge
            weekly_progress.week_num = week
            weekly_progress.progress = 0
            weekly_progress.unit = participation.challenge.unit
            weekly_progress.balance = challenge.price
            weekly_progress.save!
          end
        end
      end
    end
  end
end
