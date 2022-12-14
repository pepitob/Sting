namespace :wp do
  desc "Inizialize all weekly progresses for challenges starting today"
  task initialize: :environment do
    Challenge.all.each do |challenge|
      if (challenge.current_week  || Date.today == challenge.end_date + 1) && challenge.is_update_day
        challenge.participations.each do |participation|
          last_weekly_progress = WeeklyProgress.find_by(week_num: (challenge.current_week - 1), challenge: challenge, user: participation.user)
          weekly_progress = WeeklyProgress.find_by(week_num: challenge.current_week, challenge: challenge, user: participation.user)
          if !last_weekly_progress.updated
            if last_weekly_progress.progress >= challenge.goal_qty
              weekly_progress.balance = last_weekly_progress.balance
              last_weekly_progress.updated = true
            else
              last_weekly_progress.balance -= challenge.weekly_discount
              weekly_progress.balance = last_weekly_progress.balance
              last_weekly_progress.updated = true
              ## Notification
              message = Message.new
              message.content = "💸 #{participation.user.first_name} lost #{challenge.weekly_discount.round(1)}€ because they didn't reach their weekly goal last week."
              message.challenge = participation.challenge
              message.user = participation.user
              message.stingy = true
              message.save!
              ## End of Notification
              challenge.participations.where.not(user: participation.user).each do |member|
                last_weekly_progress_member = WeeklyProgress.find_by(week_num: (challenge.current_week - 1), challenge: challenge, user: member.user)
                weekly_progress_member = WeeklyProgress.find_by(week_num: challenge.current_week, challenge: challenge, user: member.user)
                last_weekly_progress_member.balance += (challenge.weekly_discount / (challenge.members_count - 1))
                weekly_progress_member.balance += (challenge.weekly_discount / (challenge.members_count - 1))
                last_weekly_progress_member.save!
                weekly_progress_member.save!
                ## Notification
                message = Message.new
                message.content = "💰 #{member.user.first_name} earned #{(challenge.weekly_discount / (challenge.members_count - 1)).round(1)}€ because #{participation.user.first_name} didn't reach their weekly goal last week."
                message.challenge = participation.challenge
                message.user = member.user
                message.stingy = true
                message.save!
                ## End of Notification
              end
            end
          end
          weekly_progress.save!
          last_weekly_progress.save!
        end
      end
    end
  end
end
