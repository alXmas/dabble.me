class EntrieService
  class << self
    def build_params(entry, params, current_user)
      byebug
      existing_entry = current_user.existing_entry(params[:entry][:date].to_s)

      if entry.present? && existing_entry.present? && entry != existing_entry && params[:entry][:entry].present?
        existing_entry = EntryMutator.merge(existing_entry, entry, params)
        return { merged: true, data: existing_entry.data } if existing_entry.persisted?
      elsif params[:entry][:entry].blank?
        entry.destroy
        return { deleted: true } if existing_entry.persisted?
      else
        return { updated: true, data: entry.data } if entry.update(entry_params)
      end
    end
  end
end
