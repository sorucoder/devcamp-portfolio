module VotableToggleConcern
  extend ActiveSupport::Concern

  def toggle_like(votable, redirect_path: nil)
    redirect_path = redirect_path || votable
    if current_user.voted_for?(votable) && current_user.liked?(votable)
      current_user.unlike votable
      redirect_to redirect_path, notice: "You removed your like to this #{votable.class.name.downcase}."
    else
      current_user.likes votable
      redirect_to redirect_path, notice: "You now like this #{votable.class.name.downcase}."
    end
  end

  def toggle_dislike(votable, redirect_path: nil)
    redirect_path = redirect_path || votable
    if current_user.voted_for?(votable) && current_user.disliked?(votable)
      current_user.undislike votable
      redirect_to redirect_path, notice: "You removed your dislike to this #{votable.class.name.downcase}."
    else
      current_user.dislikes votable
      redirect_to redirect_path, notice: "You now dislike this #{votable.class.name.downcase}."
    end
  end
end