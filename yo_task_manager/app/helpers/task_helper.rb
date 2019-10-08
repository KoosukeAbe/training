# frozen_string_literal: true

module TaskHelper
  def sort_asc(column_name)
    link_to '▲', { column: column_name, direction: 'asc' }
  end

  def sort_desc(column_name)
    link_to '▼', { column: column_name, direction: 'desc' }
  end

  def sort_direction
    # If params[:direction] is nil, set sort_direction to 'desc' by default
    %W[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    # If params[:column] is nill, set sort_coumn to 'created_date' by default
    Task.column_names.include?(params[:column]) ? params[:column] : 'created_at'
  end
end
