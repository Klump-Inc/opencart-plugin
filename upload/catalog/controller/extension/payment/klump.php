<?php
class kLUMP extends Controller {
    public function index() {
        $this->load->language('extension/payment/klump');
        
        $data['button_confirm'] = $this->language->get('button_confirm');

        return $this->load->view('extension/payment/klump', $data);
    }

    public function confirm() {
        if ($this->session->data['payment_method']['code'] == 'klump') {
            $this->load->model('checkout/order');
            $this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('klump_order_status_id'));
        }
    }
}
