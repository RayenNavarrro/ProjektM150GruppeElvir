CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    ALTER DATABASE CHARACTER SET utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE TABLE `Days` (
        `Id` char(36) COLLATE ascii_general_ci NOT NULL,
        `Date` datetime(6) NOT NULL,
        CONSTRAINT `PK_Days` PRIMARY KEY (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE TABLE `Icons` (
        `Id` char(36) COLLATE ascii_general_ci NOT NULL,
        `SourceUri` longtext CHARACTER SET utf8mb4 NOT NULL,
        `AltText` longtext CHARACTER SET utf8mb4 NOT NULL,
        CONSTRAINT `PK_Icons` PRIMARY KEY (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE TABLE `Menus` (
        `Id` char(36) COLLATE ascii_general_ci NOT NULL,
        `Title` longtext CHARACTER SET utf8mb4 NOT NULL,
        `PriceInternal` decimal(65,30) NOT NULL,
        `PriceExternal` decimal(65,30) NOT NULL,
        `MenuComponents` longtext CHARACTER SET utf8mb4 NULL,
        `Allergenes` longtext CHARACTER SET utf8mb4 NULL,
        `Balance` longtext CHARACTER SET utf8mb4 NULL,
        `EnvironmentalImpact` longtext CHARACTER SET utf8mb4 NULL,
        `AdditionalInformation` longtext CHARACTER SET utf8mb4 NULL,
        `DayId` char(36) COLLATE ascii_general_ci NOT NULL,
        CONSTRAINT `PK_Menus` PRIMARY KEY (`Id`),
        CONSTRAINT `FK_Menus_Days_DayId` FOREIGN KEY (`DayId`) REFERENCES `Days` (`Id`) ON DELETE CASCADE
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE TABLE `MenuIcons` (
        `IconsId` char(36) COLLATE ascii_general_ci NOT NULL,
        `MenusId` char(36) COLLATE ascii_general_ci NOT NULL,
        CONSTRAINT `PK_MenuIcons` PRIMARY KEY (`IconsId`, `MenusId`),
        CONSTRAINT `FK_MenuIcons_Icons_IconsId` FOREIGN KEY (`IconsId`) REFERENCES `Icons` (`Id`) ON DELETE CASCADE,
        CONSTRAINT `FK_MenuIcons_Menus_MenusId` FOREIGN KEY (`MenusId`) REFERENCES `Menus` (`Id`) ON DELETE CASCADE
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE TABLE `NutritionalValues` (
        `Id` char(36) COLLATE ascii_general_ci NOT NULL,
        `Title` longtext CHARACTER SET utf8mb4 NOT NULL,
        `Value` longtext CHARACTER SET utf8mb4 NOT NULL,
        `RowIndex` int NOT NULL,
        `MenuId` char(36) COLLATE ascii_general_ci NOT NULL,
        CONSTRAINT `PK_NutritionalValues` PRIMARY KEY (`Id`),
        CONSTRAINT `FK_NutritionalValues_Menus_MenuId` FOREIGN KEY (`MenuId`) REFERENCES `Menus` (`Id`) ON DELETE CASCADE
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE INDEX `IX_MenuIcons_MenusId` ON `MenuIcons` (`MenusId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE INDEX `IX_Menus_DayId` ON `Menus` (`DayId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    CREATE INDEX `IX_NutritionalValues_MenuId` ON `NutritionalValues` (`MenuId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20220613075436_InitialMigration') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20220613075436_InitialMigration', '6.0.5');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

