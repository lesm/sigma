class ReciboStepsController < ApplicationController
  before_action :authenticate_usuario!
  include Wicked::Wizard

  steps :set_cuenta, :set_conceptos

  def show
    authorize ReciboStep.new
    case step
    when :set_cuenta
      if params["contribuyente_id"].present?
        @contribuyente = Contribuyente.find_by_id(params["contribuyente_id"])
        load_cuentas_contribuyente
      end

      @cuenta_form = CuentaForm.new contribuyente_id: params["contribuyente_id"]
      @contribuyente_new = Contribuyente.new(direccion: Direccion.new)

    when :set_conceptos
      set_recibo

      cuenta_ids.each do |cuenta_id|
        build_cuenta_concepto(Cuenta.find_by_id(cuenta_id.to_i))
      end

      @cuenta_params = {
        contribuyente_id: @recibo.contribuyente.id,
        cuenta_ids: cuenta_ids
      }
    end

    render_wizard
  end

  def update
    authorize ReciboStep.new
    contribuyente_id = params["cuenta_form"]["contribuyente_id"]
    @cuenta_form = CuentaForm.new(
      contribuyente_id: Contribuyente.find_by_id(contribuyente_id),
      cuenta_ids: params["cuenta_form"]["cuenta_ids"]
    )
    @contribuyente = Contribuyente.new(direccion: Direccion.new)
    render_wizard(@cuenta_form, {}, @cuenta_form.instance_values)
  end

  def asignar_cuentas
    @contribuyente = Contribuyente.find_by_id(params[:contribuyente_id])
    load_cuentas_contribuyente if @contribuyente.present?
  end

  private

  def cuenta_ids
    return [] if params["cuenta_ids"].empty?
    params["cuenta_ids"].reject(&:blank?)
  end

  def set_recibo
    @recibo = Recibo.new
    @recibo.contribuyente = Contribuyente.find_by_id(params["contribuyente_id"])
  end

  def build_cuenta_concepto cuenta
    @recibo.conceptos.build(
      cuenta_id: cuenta.id,
      datos_concepto: cuenta.formato.constantize.new
    )
  end
end
