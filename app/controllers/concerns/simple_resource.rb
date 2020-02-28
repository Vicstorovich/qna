module SimpleResource
  extend ActiveSupport::Concern

  ALL_ACTIONS_METHODS = %i[index show new edit create update destroy].freeze

  included do
    respond_to :html
    before_action :build_resource, only: %i[new create]

    def resource_name
      controller_name.classify.underscore
    end

    def collection_name
      resource_name.pluralize
    end

    def resource_klass
      if self.class.resource_klass.nil?
        controller_name.classify.constantize
      else
        self.class.resource_klass.to_s.classify.constantize
      end
    end

    def resource
      return instance_variable_get(:"@#{resource_name}") if instance_variable_get(:"@#{resource_name}").present?

      instance_variable_set(:"@#{resource_name}", association_chain.find(params[:id]))
    end
    helper_method :resource

    def collection
      current_value = instance_variable_get("@#{collection_name}".to_sym)
      return current_value if current_value.present?

      instance_variable_set("@#{collection_name}".to_sym, applay_pagination(association_chain.all))
    end
    helper_method :collection

    def permitted_params
      raise 'Not Implemented'
    end

    def after_actions_redirect_pash
      raise 'Not Implemented'
    end

    def association_chain
      if self.class.resource_context.present? || self.class.resource_association.present?
        association_chain_by_context
      else
        resource_klass
      end
    end

    def association_chain_by_context
      context_method = self.class.resource_context

      if respond_to? context_method, true
        context = send(context_method)
      else
        raise "Undefined context_method to #{context_method}"
      end

      inherited_resource? ? build_ancestor_resource(context) : build_chain_resources(context)
    end

    def inherited_resource?
      self.class.resource_ancestor.present? && self.class.resource_ancestor != resource_klass
    end

    def build_ancestor_resource(chain_link)
      ancestor = self.class.resource_ancestor.to_s.pluralize.underscore.to_sym

      if chain_link.respond_to? ancestor, true
        context_ancesstor = chain_link.send(ancestor)
      else
        raise "Undefined context_method to #{ancestor}"
      end

      build_chain_resources(context_ancesstor)
    end

    def build_chain_resources(chain_link)
      relation_method = collection_name.to_sym

      if chain_link.respond_to? relation_method
        chain_link.public_send relation_method
      else
        raise "#{chain_link.class.name} has no relation #{relation_method}"
      end
    end

    def build_resource
      instance =
        if params[resource_name.to_sym].present?
          association_chain.is_a?(ActiveRecord::Relation) ? association_chain.build(permitted_params) : association_chain.new(permitted_params)
        else
          association_chain.is_a?(ActiveRecord::Relation) ? association_chain.build : association_chain.new
        end

      instance_variable_set("@#{resource_name}".to_sym, instance)
    end

    def applay_pagination(chain)
      per_page = self.class.paginate_collection

      per_page.present? ? chain.page(params[:page]).per(per_page) : chain
    end
  end

  class_methods do
    def add_actions(*actions)
      if actions.count == 1 && actions[0] == :all
        ALL_ACTIONS_METHODS.each do |action|
          send(:public, action)
        end
      else
        actions.each do |action|
          send(:public, action)
        end
      end
    end

    def resource_ancestor(name = nil)
      @@resource_ancestor ||= name
      @@resource_ancestor
    end

    def resource_klass(name = nil)
      @@resource_klass ||= name
      @@resource_klass
    end

    def resource_context(name = nil)
      @@resource_context ||= name
      @@resource_context
    end

    def paginate_collection(per_page = nil)
      @@paginate_collection ||= per_page
      @@paginate_collection
    end
  end

  private

  def index
    respond_with(collection)
  end

  def show; end

  def new
    respond_with(resource)
  end

  def create
    resource.save
    respond_with resource, location: after_actions_redirect_pash
  end

  def edit; end

  def update
    resource.assign_attributes(permitted_params)
    resource.save
    respond_with resource, location: after_actions_redirect_pash
  end

  def destroy
    resource.destroy
    respond_with resource, location: after_actions_redirect_pash
  end
end
