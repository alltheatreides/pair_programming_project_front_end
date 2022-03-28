-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 28 mars 2022 à 13:57
-- Version du serveur : 10.4.21-MariaDB
-- Version de PHP : 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `morphee`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220314143346', '2022-03-14 14:34:27', 46),
('DoctrineMigrations\\Version20220314145932', '2022-03-14 14:59:52', 67),
('DoctrineMigrations\\Version20220314150928', '2022-03-14 15:09:54', 20),
('DoctrineMigrations\\Version20220314151126', '2022-03-14 15:11:34', 158),
('DoctrineMigrations\\Version20220314152137', '2022-03-14 15:21:45', 162);

-- --------------------------------------------------------

--
-- Structure de la table `statistics`
--

CREATE TABLE `statistics` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `heure_couche` datetime NOT NULL,
  `heure_reveil` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `statistics`
--

INSERT INTO `statistics` (`id`, `user_id`, `date`, `heure_couche`, `heure_reveil`) VALUES
(3, 1, '2022-03-01 00:00:00', '2022-03-15 14:03:13', '2022-03-15 20:03:13'),
(4, 1, '2022-03-01 00:00:00', '2022-03-15 14:03:13', '2022-03-15 20:03:13'),
(5, 1, '2022-03-01 00:00:00', '2022-03-15 14:03:13', '2022-03-15 20:03:13'),
(6, 1, '2022-03-28 12:18:02', '2022-03-27 19:18:02', '2022-03-28 06:00:02'),
(7, 1, '2022-03-28 12:18:02', '2022-03-27 19:18:02', '2022-03-28 06:00:02');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `user_updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `user_name`, `user_email`, `user_password`, `user_created_at`, `user_updated_at`) VALUES
(1, 'UserTest', 'idgaf@gmail.com', '$2y$10$cR7tjNXARFas5/edmtwuW./kdf887g.AwuIlwyMZFfMd12Pd5UNOG', '2022-03-15 09:59:36', '2022-03-15 09:59:36'),
(2, 'UserTest2', 'idgaf@gmaill.com', '$2y$10$oTRmVsSDuSF.4Mjb9QA2wOEQDctq1LIcVY4zep7QTZAG3BkHALlAO', '2022-03-17 08:27:05', '2022-03-17 08:27:05'),
(3, 'UserTest3', 'idgaf@gmailll.com', '$2y$10$iEgvDOglg63.05rw/iakSeudHCCmq0RHbNs6Bwnnz./etcKytaHoi', '2022-03-17 08:27:17', '2022-03-17 08:27:17'),
(4, 'user3', 'test@hotmail.com', '$2y$10$7kmj9sSQITeZDPKNLj2HP.NLsxl0/KFosdaNeWbTmCm/JEJ3S5F4C', '2022-03-23 11:25:37', '2022-03-23 11:25:37'),
(5, 'usertest4', 'test@gmail.com', '$2y$10$X88eB1vBxDRo7uTfA7G93etFMTnwMXbAn9huHh7o6yKCEDZXtKb2m', '2022-03-23 11:26:24', '2022-03-23 11:26:24');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E2D38B22A76ED395` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `FK_E2D38B22A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
