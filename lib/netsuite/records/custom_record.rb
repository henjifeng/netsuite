module NetSuite
  module Records
    class CustomRecord
      include Support::Fields

      fields :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :created,
        :custom_record_id, :description, :disclaimer, :enabl_email_merge, :enable_numbering, :include_name,
        :is_available_offline, :is_inactive, :is_numbering_updateable, :is_ordered, :last_modified, :name,
        :numbering_current_number, :numbering_init, :numbering_min_digits, :numbering_prefix, :numbering_suffix,
        :record_name, :script_id, :show_creation_date, :show_creation_date_on_list, :show_id, :show_last_modified_on_list,
        :show_last_modified, :show_notes, :show_owner, :show_owner_allow_change, :show_owner_on_list, :use_permissions

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def self.get(id, options = {})
        options.merge!(:external_id => id) if id
        options.merge!(:type_id => type_id) unless options[:type_id]
        response = Actions::Get.call(self, options.merge!(:custom => true))
        if response.success?
          new(response.body)
        else
          raise RecordNotFound, "#{self} with ID=#{id} could not be found"
        end
      end

      def self.type_id(id = nil)
        if id
          @type_id = id
        else
          @type_id
        end
      end

    end
  end
end