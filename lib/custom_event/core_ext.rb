
Object.class_eval do
  def custom_event(event)
    define_method event do
      unless block_given?
        raise "Event defined without block given"
      end

      before_hook = "before_#{event}"
      around_hook = "around_#{event}"
      after_hook = "after_#{event}"

      send before_hook if respond_to? before_hook
      send around_hook if respond_to? around_hook
      yield
      send around_hook if respond_to? around_hook
      send after_hook if respond_to? after_hook
    end
  end
end
