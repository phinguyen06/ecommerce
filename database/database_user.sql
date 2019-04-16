CREATE USER 'ebizdeal_user'@'localhost' IDENTIFIED BY 'ebizdeal_user';

GRANT SELECT,INSERT,UPDATE,DELETE
    ON ebizdeal.*
     TO 'ebizdeal_user'@'localhost';

