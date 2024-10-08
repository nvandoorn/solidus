# frozen_string_literal: true

class SolidusAdmin::AdjustmentReasons::Index::Component < SolidusAdmin::RefundsAndReturns::Component
  def model_class
    Spree::AdjustmentReason
  end

  def search_url
    solidus_admin.adjustment_reasons_path
  end

  def search_key
    :name_or_code_cont
  end

  def page_actions
    render component("ui/button").new(
      tag: :a,
      text: t('.add'),
      href: solidus_admin.new_adjustment_reason_path, data: { turbo_frame: :new_adjustment_reason_modal },
      icon: "add-line",
      class: "align-self-end w-full",
    )
  end

  def turbo_frames
    %w[
      new_adjustment_reason_modal
      edit_adjustment_reason_modal
    ]
  end

  def row_url(adjustment_reason)
    spree.edit_admin_adjustment_reason_path(adjustment_reason, _turbo_frame: :edit_adjustment_reason_modal)
  end

  def batch_actions
    [
      {
        label: t('.batch_actions.delete'),
        action: solidus_admin.adjustment_reasons_path,
        method: :delete,
        icon: 'delete-bin-7-line',
      },
    ]
  end

  def columns
    [
      :name,
      :code,
      {
        header: :active,
        data: ->(adjustment_reason) do
          adjustment_reason.active? ? component('ui/badge').yes : component('ui/badge').no
        end
      },
    ]
  end
end
