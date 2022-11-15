# frozen_string_literal: true

# my controller
class ArrayController < ApplicationController
  before_action :set_original_arr, only: :result
  before_action :validate_string, only: :result
  before_action :validate_negative, only: :result
  before_action :validate_last, only: :result
  before_action :validate_minuses_and_points, only: :result
  before_action :summa, only: :result
  before_action :validate_all, only: :result

  def input; end

  def result
    @fixed = fix_array(@orig_array.split.map(&:to_f))
    @sum = summa
  end

  private

  def set_original_arr
    @orig_array = params[:input_array]
  end

  def validate_last
    flash[:notice] = 'Последний символ должен быть числом' unless @orig_array.match(/\D$/).nil?
  end

  def validate_string
    flash[:alert] = "Исправьте #{@orig_array.match(/\D*[^\s\d\-.]/)}" unless
    @orig_array.match(/\D*[^\s\d\-.]/).nil?
  end

  def validate_minuses_and_points
    flash[:warning] = 'После - и . должно быть число' unless @orig_array.match(/(-\D+|\.\D+)/).nil?
  end

  def validate_negative
    flash[:info] = 'Добавьте хотя бы один отрицательный элемент' if @orig_array.match(/-\d/).nil?
  end

  def summa
    s = 0
    arr = @orig_array.split.map(&:to_f)
    arr.each do |elem|
      s += elem if (elem % 15).zero?
    end
    flash[:error] = 'Нет чисел, кратных 15' if s.zero?
    s
  end

  def validate_all
    redirect_to home_path unless flash.empty?
  end

  def fix_array(arr)
    index = 0
    arr.each do |elem|
      break if elem.negative?

      index += 1
    end
    arr.insert(index, summa).join(' | ')
  end
end
