module ApplicationHelper
  def error_class(target, field)
    target.errors[field].any? ? "error": ""
  end

  def first_error_for(target, field)
    if target.errors[field].any?
      render 'shared/field_error', target: target, field: field
    end
  end

  def readable_date(date)
    date.strftime("#{date.day.ordinalize} of %B")
  end

  def current_season
    season = Season.all
    .select{ |season| season.next_pack_with_lead_time_from(Time.now).present? }
    .sort{ |a,b| a.first_pack.pack_date <=> b.first_pack.pack_date }.first

    season || Season.order(created_at: :desc).limit(1).last
  end

  def icon_class(label)
    case label
    when "About"
      'fa fa-users'
    when "Local Food"
      'bbfh-eggplant'
    when "Get Involved"
      'fa fa-exchange'
    when "Resources"
      'fa fa-book'
    when "Producers"
      'bbfh-producer'
    else
      ''
    end
  end
end
