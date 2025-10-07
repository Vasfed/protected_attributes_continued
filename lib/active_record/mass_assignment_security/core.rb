module ActiveRecord
  module MassAssignmentSecurity
    module Core

      def initialize(attributes = nil, options = {})
        @new_record = true
        self.class.define_attribute_methods
        @attributes = self.class._default_attributes.deep_dup

        init_internals
        initialize_internals_callback

        # +options+ argument is only needed to make protected_attributes gem easier to hook.
        assign_attributes(attributes, options) if attributes

        yield self if block_given?
        _run_initialize_callbacks
      end

      private

      if ActiveRecord.gem_version < Gem::Version.new('7.2')
        # unsure if needed
        def init_attributes(attributes, options = {})
          assign_attributes(attributes, options)
        end
      end

      def init_internals
        super
        @mass_assignment_options = nil
      end

    end
  end
end
