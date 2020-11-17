module EntryMutator
  def merge(existing_entry, entry, params)
    existing_entry.body += "<hr>#{params[:entry][:entry]}"
    existing_entry.inspiration_id = params[:entry][:inspiration_id] if params[:entry][:inspiration_id].present?
    if existing_entry.image_url_cdn.blank? && entry.image.present?
      existing_entry.image = entry.image
    elsif entry.image.present?
      existing_entry.body += "<br><a href='#{entry.image_url_cdn}'><img src='#{entry.image_url_cdn}'></a>"
    end

    entry.delete if existing_entry.save

    existing_entry
  end
end
