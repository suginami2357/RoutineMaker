class RoutinesController < ApplicationController
  
  def top
    if !logged_in?
      redirect_to controller: :users, action: :new;
    end
    
    #データベースに保存された日付(2000-01-01)と同様の値を固定値としている
    hh = Time.current.strftime("%H").to_i;
    mm = Time.current.strftime("%M").to_i;
    time = DateTime.new(2000, 1, 1, hh, mm, 00, "+09:00")
    
    #開始時刻以上かつ終了時刻未満のレコードを検索
    @routines = Routine.where('start_time <= ? AND ? < end_time', time, time);
  end
  
  def index
    #開始時刻が早い順かつ終了時刻が早い順
    @routines = Routine.where(user_id: current_user.id).order(:start_time=>:asc, :end_time=>:asc)
  end
  
  def show
    @routine = Routine.find_by(id: params[:id], user_id: current_user.id);
    if @routine.nil?
      redirect_to controller: :routines, action: :index
    end
  end

  def new
    @routine = Routine.new;
  end
  
  def create
    @routine = Routine.new(routine_params);
    if @routine.save
      redirect_to controller: :routines, action: :index
    else
      flash.now[:danger] = @routine.errors.full_messages.first
      render action: :new
    end
  end
  
  def edit
    @routine = Routine.find_by(id: params[:id], user_id: current_user.id);
    if @routine.nil?
      redirect_to controller: :routines, action: :index
    end
  end
  
  def update
    @routine = Routine.find_by(id: params[:id], user_id: current_user.id);
    if @routine.update(routine_params);
      flash[:success] = "保存しました。";
      redirect_to controller: :routines, action: :index
    else
      flash.now[:danger] = @routine.errors.full_messages.first
      render controller: :routines, action: :edit
    end
  end
  
  def destroy
    @routine = Routine.find_by(id: params[:id], user_id: current_user.id);
    
    if @routine.nil?
      redirect_to controller: :routines, action: :edit
    else
      @routine.destroy;
      flash[:success] = "削除しました。";
      redirect_to controller: :routines, action: :index
    end
  end
  
    private
    
    # ストロングパラメータ
    def routine_params
      #paramsの中身 => {routine: {id: "", start_time: ""}...}からpermitで指定した値を抽出
      params.require(:routine).permit(:id, :content)
      .merge(
        start_time: Time.zone.parse("2000-01-01 #{params[:routine][:start_time]}"), 
        end_time: Time.zone.parse("2000-01-01 #{params[:routine][:end_time]}"), 
        user_id: current_user.id
      )
    end
end