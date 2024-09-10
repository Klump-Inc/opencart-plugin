<?php
namespace Opencart\Admin\Model\Extension\Klump\Payment;

class Klump extends \Opencart\System\Engine\Model {
    public function install() {
        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "klump_order` (
                `klump_order_id` INT(11) NOT NULL AUTO_INCREMENT,
                `order_id` INT(11) NOT NULL,
                `transaction_id` VARCHAR(100) NOT NULL,
                `date_added` DATETIME NOT NULL,
                `date_modified` DATETIME NOT NULL,
                `capture_status` INT(1) DEFAULT NULL,
                `void_status` INT(1) DEFAULT NULL,
                `refund_status` INT(1) DEFAULT NULL,
                PRIMARY KEY (`klump_order_id`)
            ) ENGINE=MyISAM DEFAULT COLLATE=utf8_general_ci;
        ");
    }

    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "klump_order`;");
    }
}