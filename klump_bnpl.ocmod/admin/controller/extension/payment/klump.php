<?php
class Klump extends Controller {

    private $error = [];

    /**
     * Entry function.
     *
     * @return void
     */
    public function index() {
        $this->load->language('extension/payment/klump');
        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('klump', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('marketplace/extension', 'user_token=' . $this->session->data['user_token'] . '&type=payment', true));
        }

        $data['action'] = $this->url->link('extension/payment/klump', 'user_token=' . $this->session->data['user_token'], true);
        $data['cancel'] = $this->url->link('marketplace/extension', 'user_token=' . $this->session->data['user_token'] . '&type=payment', true);

        if (isset($this->request->post['klump_status'])) {
            $data['klump_status'] = $this->request->post['klump_status'];
        } else {
            $data['klump_status'] = $this->config->get('klump_status');
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/payment/klump', $data));
    }

    /**
     * Validate the form.
     *
     * @return array
     */
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/payment/klump')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }

    public function install() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('payment_custompayment', ['payment_custompayment_status' => 1]);
    }
    
    public function uninstall() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('payment_custompayment');
    }
    
}
