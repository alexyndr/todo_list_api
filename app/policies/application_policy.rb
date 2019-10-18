class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    belongs_to_user?
  end

  def show?
    belongs_to_user?
  end

  def create?
    belongs_to_user?
  end

  def new?
    create?
  end

  def update?
    belongs_to_user?
  end

  def update_position?
    update?
  end

  def update_complete?
    update?
  end

  def edit?
    update?
  end

  def destroy?
    belongs_to_user?
  end
end
