module SubscriptionHelper
  def get_subscriptions(season)
    %w(large standard small).map do |size|
      text_for scope_for( season, size ), size
    end.reject(&:empty?).join(", ")
  end

  private

  def scope_for(season,size)
    @subscriptions.where(season: season, box_size: size)
  end

  def text_for( scope, size )
    box_name = Subscription::SIZES[size]
    # If we are going to be joining multiple strings
    # Or if more than one subscription exists for this size
    if @subscriptions.count > 1 || scope.count > 1
      "#{scope.count} #{box_name.pluralize}"
    elsif scope.count > 0
      box_name
    else
      ""
    end
  end
end