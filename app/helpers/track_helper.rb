module TrackHelper
  def track_event(action)
    if ENV['GOOGLE_ANALYTICS_ID'].present?
      tracker = Staccato.tracker(ENV['GOOGLE_ANALYTICS_ID'])
      tracker.event(category: 'Web Entry', action: action, label: current_user.user_key)
    end
  end
end
