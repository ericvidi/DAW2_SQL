CREATE TABLE `user` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(50),
  `last_name` varchar(50),
  `email` varchar(50) UNIQUE,
  `password` varchar(255),
  `id_user_type` integer
);

CREATE TABLE `user_profile_information` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(20),
  `address` varchar(100),
  `description` varchar(255),
  `website` varchar(255),
  `twitter_account` varchar(255),
  `github_account` varchar(255),
  `instagram_account` varchar(255),
  `facebook_account` varchar(255),
  `image` varchar(255) DEFAULT '../recursos/imatges/user_default_image.jpg',
  `id_user` integer
);

CREATE TABLE `ability` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(40),
  `description` varchar(255)
);

CREATE TABLE `ability_user_profile_information` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_ability` integer,
  `ability_value` integer,
  `id_user_profile_information` integer
);

CREATE TABLE `user_type` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `type` varchar(20)
);

CREATE TABLE `proposal` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `title` varchar(100),
  `location` varchar(100),
  `description` varchar(255),
  `image` varchar(255),
  `created` timestamp,
  `id_category_proposal_project` integer,
  `id_state_proposal_project` integer,
  `id_creator` integer
);

CREATE TABLE `project` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `title` varchar(100),
  `location` varchar(100),
  `description` varchar(255),
  `image` varchar(255),
  `created` timestamp,
  `id_proposal` integer,
  `id_category_proposal_project` integer,
  `id_state_proposal_project` integer,
  `id_creator` integer
);

CREATE TABLE `category_proposal_project` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `category` varchar(255)
);

CREATE TABLE `state_proposal_project` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `state` varchar(20)
);

CREATE TABLE `user_proposal` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_user` integer,
  `id_proposal` integer,
  `id_user_role` integer
);

CREATE TABLE `user_role` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `role` varchar(20)
);

CREATE TABLE `document` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(255),
  `last_time_modified` timestamp,
  `id_type_document` integer,
  `id_parent_document` integer,
  `id_project` integer,
  `id_user` integer
);

CREATE TABLE `type_document` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(50)
);

CREATE TABLE `resource` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100),
  `description` varchar(255),
  `provided_by` integer,
  `id_project` integer
);

CREATE TABLE `task` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100),
  `description` varchar(255),
  `created_by` integer,
  `assigned_to` integer,
  `created` timestamp,
  `start_date` timestamp,
  `end_date` timestamp,
  `estimated_time_in_minutes` integer,
  `id_project` integer,
  `id_task_state` integer
);

CREATE TABLE `task_state` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `state` varchar(20)
);

CREATE TABLE `reservation` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `created` timestamp,
  `start_time` timestamp,
  `end_time` timestamp,
  `id_machine` integer,
  `created_by` integer
);

CREATE TABLE `machine` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100),
  `brand` varchar(50),
  `model` varchar(50),
  `description` varchar(255),
  `price` float,
  `serial_number` varchar(255) UNIQUE,
  `starting_date` timestamp NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT '../recursos/imatges/maquines/machine-default.jpg'
);

CREATE TABLE `material` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100),
  `brand` varchar(50),
  `description` varchar(255),
  `price` float,
  `code` varchar(255) UNIQUE
);

CREATE TABLE `incident` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `title` varchar(50),
  `description` varchar(255),
  `created` timestamp NOT NULL,
  `id_machine` integer,
  `id_user` integer,
  `id_incident_state` integer
);

CREATE TABLE `incident_state` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `state` varchar(20) NOT NULL
);

CREATE TABLE `invoice` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL,
  `total_no_tax` float,
  `total_tax` float,
  `total` float,
  `id_user` integer
);

CREATE TABLE `invoice_row` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `quantity` float,
  `discount` float,
  `tax` float,
  `id_material` integer,
  `id_invoice` integer,
  `id_machine` integer
);

CREATE TABLE `user_message` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_user1` int,
  `id_user2` int,
  `subject` varchar(50)
);

CREATE TABLE `message` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `message` varchar(255),
  `timestamp` timestamp NOT NULL,
  `user1read` tinyint(1),
  `user2read` tinyint(1),
  `id_user_message` int
);

CREATE TABLE `user_log` (
  `id` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `action` varchar(20),
  `time` timestamp NOT NULL,
  `remote_ip` varchar(20),
  `browser` varchar(20),
  `id_user` integer
);

ALTER TABLE `user` ADD FOREIGN KEY (`id_user_type`) REFERENCES `user_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_profile_information` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `project` ADD FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proposal` ADD FOREIGN KEY (`id_state_proposal_project`) REFERENCES `state_proposal_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `project` ADD FOREIGN KEY (`id_state_proposal_project`) REFERENCES `state_proposal_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_proposal` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_proposal` ADD FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_proposal` ADD FOREIGN KEY (`id_user_role`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `document` ADD FOREIGN KEY (`id_parent_document`) REFERENCES `document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `document` ADD FOREIGN KEY (`id_type_document`) REFERENCES `type_document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `document` ADD FOREIGN KEY (`id_project`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `document` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `resource` ADD FOREIGN KEY (`provided_by`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `resource` ADD FOREIGN KEY (`id_project`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `task` ADD FOREIGN KEY (`id_project`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `reservation` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `reservation` ADD FOREIGN KEY (`id_machine`) REFERENCES `machine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `incident` ADD FOREIGN KEY (`id_machine`) REFERENCES `machine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `incident` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `incident` ADD FOREIGN KEY (`id_incident_state`) REFERENCES `incident_state` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `invoice` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `invoice_row` ADD FOREIGN KEY (`id_material`) REFERENCES `material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `invoice_row` ADD FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `invoice_row` ADD FOREIGN KEY (`id_machine`) REFERENCES `machine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `task` ADD FOREIGN KEY (`id_task_state`) REFERENCES `task_state` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proposal` ADD FOREIGN KEY (`id_category_proposal_project`) REFERENCES `category_proposal_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proposal` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `project` ADD FOREIGN KEY (`id_creator`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `project` ADD FOREIGN KEY (`id_category_proposal_project`) REFERENCES `category_proposal_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_message` ADD FOREIGN KEY (`id_user1`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_message` ADD FOREIGN KEY (`id_user2`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `message` ADD FOREIGN KEY (`id_user_message`) REFERENCES `user_message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ability_user_profile_information` ADD FOREIGN KEY (`id_ability`) REFERENCES `ability` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ability_user_profile_information` ADD FOREIGN KEY (`id_user_profile_information`) REFERENCES `user_profile_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_log` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `task` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `task` ADD FOREIGN KEY (`assigned_to`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO `user_type` (`id`, `type`) VALUES (NULL, 'usuari'), (NULL, 'administrador');

INSERT INTO `ability` (`name`, `description`) VALUES
('Impressió 3D', NULL),
('Fresat CNC', NULL),
('Mecanitzats', NULL),
('Programació electrònica', NULL),
('Disseny industrial', NULL),
('Modelat 3D orgànic', NULL),
('RV/RA', NULL);


INSERT INTO `category_proposal_project` (`category`) VALUES
('Esports'),
('Motor'),
('Moda'),
('Fitness'),
('Música'),
('Robòtica'),
('Videojocs'),
('Ciència'),
('Matemàtiques'),
('Social');

INSERT INTO `incident_state` (`state`) VALUES
('Obert'),
('En procés'),
('Tancat'),
('Inactiu');

INSERT INTO `state_proposal_project` (`state`) VALUES
('Actiu'),
('Inactiu');

INSERT INTO `task_state` (`state`) VALUES
('Pendent'),
('En progrés'),
('Fet');

INSERT INTO `type_document` (`name`) VALUES
('carpeta'),
('fitxer');

INSERT INTO `user` (`name`, `last_name`, `email`, `password`, `id_user_type`) VALUES
('Max', 'Verstappen', 'verstii_33@xtec.cat', 'Admin1234', 2),
('admin', 'admin', 'admin@iesmontsia.org', 'admin', 2),
('Charles', 'Leclerc', 'ferrarif1@xtec.cat', 'xdxd123xdxd', 1),
('Lando', 'Norris', 'carlando@xtec.cat', 'carlando_mclaren', 1),
('usuari', 'usuari', 'usuari@iesmontsia.org', 'usuari', 1);

INSERT INTO `user_role` (`role`) VALUES
('Maker'),
('Promotor');

INSERT INTO `proposal` (`title`, `location`, `description`, `image`, `created`, `id_category_proposal_project`, `id_state_proposal_project`,`id_creator`) VALUES 
('smart pen', 'Amposta', 'un boligraf inteligent', 'imatge', current_timestamp(), '8', '1','2'),
('respall de dents amb musica', 'Tortosa', 'En aquesta Proposta ....', 'imatge', current_timestamp(), '8', '2','3'),
('parasol intel·ligent', 'Cambrils', 'En aquesta proposta...', 'imatge', current_timestamp(), '3', '2','4'),
('bola de llums amb musica', 'La Ràpita', 'En aquesta proposta...', 'imatge', current_timestamp(), '5', '1','1'),
('braç robòtic', 'Deltebre', 'En aquesta proposta', 'imatge', current_timestamp(), '8', '2','5');

INSERT INTO `project` (`title`, `location`, `description`, `image`, `created`, `id_proposal`, `id_category_proposal_project`, `id_state_proposal_project`,`id_creator`) VALUES
('llapis inteligent', 'Amposta', 'En aquest projecte', '../recursos/imatges/proposta1.jpg', current_timestamp(), '1', '8', '1','2'),
('braç robòtic', 'Deltebre', 'En aquest projecte...', 'imatge', current_timestamp(), '5', '8', '2','1'),
('bola de llums', 'La Ràpita', 'En aquest projecte...', 'imatge', current_timestamp(), '4', '5', '2','3');

INSERT INTO `task` (`name`, `description`, `created_by`, `assigned_to`, `created`, `start_date`, `end_date`, `estimated_time_in_minutes`, `id_project`, `id_task_state`) VALUES
('tasca1', 'introduccio', '3', '4', current_timestamp(), '2021-12-02 16:25:36', '2021-12-02 19:25:36', '30', '1', '1'),
('impressio estructura', 'impressio 3d de la estructura', '1', '1', current_timestamp(), '2021-12-03 16:29:06', '2021-12-02 16:45:06', '15', '1', '1'),
('reparacio de circuits', 'reparacio', '1', '4', current_timestamp(), '2021-12-25 16:32:54', '2021-12-25 18:32:54', '120', '2', '2'),
('bola', 'portar la bola', '2', '3', current_timestamp(), '2021-12-22 16:35:04', '2021-12-22 16:40:44', '5', '3', '3');

INSERT INTO `document` (`id`, `name`, `last_time_modified`, `id_type_document`, `id_parent_document`, `id_project`, `id_user`) VALUES
(1, 'root', '2021-12-09 15:46:44', 1, NULL, 3, 3),
(2, 'root', '2021-12-09 15:47:24', 1, NULL, 2, 3),
(3, 'docs', '2021-12-09 15:59:17', 1, 2, 2, 3),
(4, 'info.txt', '2021-12-09 15:59:48', 2, 3, 2, 3);


INSERT INTO `machine` (`id`, `name`, `brand`, `model`, `description`, `price`, `serial_number`, `starting_date`, `image`) VALUES
(1, 'impresora 3D', 'Anet', 'ET5 Pro', 'Anet ET5 Pro Impresora 3D\r\n', 499.9, '365201598', '2021-12-13 19:12:55', '../recursos/imatges/maquines/impresora-3d.jpg'),
(2, 'Talladora de vinils', 'Roland', 'CAMM-1 GR2-640/540', 'Roland CAMM-1 GR2-640/540\r\n', 285, '578632596', '2021-12-13 19:15:41', '../recursos/imatges/maquines/cortadora-vinilos.jpg'),
(3, 'Fresadora CNC', 'CNC Bárcenas', '1325-V', 'Fresadora CNC 1325-V\r\n', 381, '748526321', '2021-12-13 19:11:37', '../recursos/imatges/maquines/fresadora-cnc.jpg'),
(4, 'Talladora làser', 'bodor', 'C Serie', 'Bodor c-serie\r\n', 479, '852369741', '2021-12-02 15:12:10', '../recursos/imatges/maquines/machine-default.jpg');

INSERT INTO `reservation` (`id`, `created`, `start_time`, `end_time`, `id_machine`, `created_by`) VALUES
(1, '2021-12-02 16:15:30', '2021-12-28 09:00:00', '2021-12-28 09:45:00', 1, 3),
(2, '2021-12-02 16:15:30', '2021-12-28 09:50:00', '2021-12-28 10:50:00', 3, 3),
(3, '2021-12-02 16:18:10', '2021-12-31 22:45:00', '2021-12-31 22:59:59', 2, 3),
(4, '2021-12-02 16:18:10', '2022-01-01 09:30:00', '2022-01-01 10:30:00', 3, 3),
(5, '2021-12-02 16:19:27', '2021-01-05 16:10:00', '2021-01-05 17:00:00', 1, 3),
(6, '2021-12-03 14:23:46', '2021-12-17 15:00:00', '2021-12-17 15:50:00', 4, 4);

INSERT INTO `user_profile_information` (`id`, `phone_number`, `address`, `description`, `website`, `twitter_account`, `github_account`, `instagram_account`, `facebook_account`, `image`, `id_user`) VALUES
(1, '638678551', 'Carrer Barcelona 58', 'Sóc campió del món.', 'https://google.com/', 'https://twitter.com/', 'https://github.com/', 'https://instagram.com/', 'https://facebook.com/', '../recursos/imatges/user_default_image.jpg', 1),
(2, '638678551', 'Carrer Barcelona 58', 'Aquesta és la meva descripció.', 'https://google.com/', 'https://twitter.com/', 'https://github.com/', 'https://instagram.com/', 'https://facebook.com/', '../recursos/imatges/user_default_image.jpg', 2),
(3, '638678551', 'Carrer Barcelona 58', 'Aquesta és la meva descripció.', 'https://google.com/', 'https://twitter.com/', 'https://github.com/', 'https://instagram.com/', 'https://facebook.com/', '../recursos/imatges/user_default_image.jpg', 3),
(4, '638678551', 'Carrer Barcelona 58', 'Aquesta és la meva descripció.', 'https://google.com/', 'https://twitter.com/', 'https://github.com/', 'https://instagram.com/', 'https://facebook.com/', '../recursos/imatges/user_default_image.jpg', 4),
(5, '638678551', 'Carrer Barcelona 58', 'Aquesta és la meva descripció.', 'https://google.com/', 'https://twitter.com/', 'https://github.com/', 'https://instagram.com/', 'https://facebook.com/', '../recursos/imatges/user_default_image.jpg', 5);


INSERT INTO `user_proposal` (`id`, `id_user`, `id_proposal`, `id_user_role`) VALUES
(1, 1, 1, 2),(2, 1, 3, 1),(3, 1, 5, 2),(4, 2, 1, 1),(5, 2, 5, 2),(6, 3, 1, 1),(7, 3, 5, 2),(8, 4, 1, 1),(9, 4, 5, 2),(10, 5, 1, 1),(11, 5, 5, 2);

INSERT INTO `ability_user_profile_information` (`id`, `id_ability`, `ability_value`, `id_user_profile_information`) VALUES
(1, 1, 70, 1),(2, 5, 33, 1),(3, 2, 99, 1),(4, 7, 1, 1),(5, 3, 55, 1),(6, 4, 55, 1),(7, 6, 6, 1),(8, 1, 70, 2),(9, 5, 33, 2),(10, 2, 99, 2),(11, 7, 1, 2),(12, 3, 55, 2),(13, 4, 55, 2),(14, 6, 6, 2),(15, 1, 70, 3),(16, 5, 33, 3),
(17, 2, 99, 3),(18, 7, 1, 3),(19, 3, 55, 3),(20, 4, 55, 3),(21, 6, 6, 3),(22, 1, 70, 4),(23, 5, 33, 4),(24, 2, 99, 4),(25, 7, 1, 4),(26, 3, 55, 4),(27, 4, 55, 4),(28, 6, 6, 4),(29, 1, 70, 5),(30, 5, 33, 5),(31, 2, 99, 5),
(32, 7, 1, 5),(33, 3, 55, 5),(34, 4, 55, 5),(35, 6, 6, 5);

INSERT INTO `resource` (`name`, `description`, `provided_by`, `id_project`) VALUES 
('Plastic', 'És un plàstic', '3', '2'),
('Tinta', 'tinta', '1', '1'),
('RaspBerry Pi', 'ordinador', '1', '1');