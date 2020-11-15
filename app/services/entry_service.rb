class EntrieService
  class << self
    # тут короче жара нужно разбираться ) 
    # по делу где билдится данные нужно создать EntrieMutator.update ... 
    def build_params(params, current_user)
      @existing_entry.body += "<hr>#{params[:entry][:entry]}"
      @existing_entry.inspiration_id = params[:entry][:inspiration_id] if params[:entry][:inspiration_id].present?
      if @existing_entry.image_url_cdn.blank? && @entry.image.present?
        @existing_entry.image = @entry.image
      elsif @entry.image.present?
        @existing_entry.body += "<br><a href='#{@entry.image_url_cdn}'><img src='#{@entry.image_url_cdn}'></a>"
      end
      if @existing_entry.save
        @entry.delete
        flash[:notice] = "Merged with existing entry on #{@existing_entry.date.strftime('%B %-d')}."
        track_ga_event('Update')
        redirect_to day_entry_path(year: @existing_entry.date.year, month: @existing_entry.date.month, day: @existing_entry.date.day) and return
      else
        render 'edit'
      end
    elsif params[:entry][:entry].blank?
      @entry.destroy
      flash[:notice] = 'Entry deleted!'
      redirect_back_or_to entries_path
    else
      if @entry.update(entry_params)
        track_ga_event('Update')
        flash[:notice] = "Entry successfully updated!"
        redirect_to day_entry_path(year: @entry.date.year, month: @entry.date.month, day: @entry.date.day)
      else
        render 'edit'
      end
    end
  end
end
