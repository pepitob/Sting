namespace :wp do
  desc "Inizialize all weekly progresses for challenges starting today"
  task initialize: :environment do
    Challenge.all.each do |challenge|
      if (challenge.current_week  || Date.today == challenge.end_date + 1) && challenge.is_update_day
        challenge.participations.each do |participation|
          last_weekly_progress = WeeklyProgress.find_by(week_num: (challenge.current_week - 1), challenge: challenge, user: participation.user)
          weekly_progress = WeeklyProgress.find_by(week_num: challenge.current_week, challenge: challenge, user: participation.user)
          if  last_weekly_progress.progress >= challenge.goal_qty
            weekly_progress.balance = last_weekly_progress.balance
          else
            last_weekly_progress.balance -= weekly_discount
            weekly_progress.balance = last_weekly_progress.balance
            challenge.participations.where( user: !participation.user).each do |members|
              last_weekly_progress_member = WeeklyProgress.find_by(week_num: (challenge.current_week - 1), challenge: challenge, user: member.user)
              weekly_progress_member = WeeklyProgress.find_by(week_num: challenge.current_week, challenge: challenge, user: member.user)
              last_weekly_progress_member.balance += (weekly_discount / challenge.members_count)
              weekly_progress_member.balance += (weekly_discount / challenge.members_count)
              last_weekly_progress_member.save!
              weekly_progress_member.save!
            end
          end
            weekly_progress.save!
            last_weekly_progress.save!
        end
      end
    end
  end
end
