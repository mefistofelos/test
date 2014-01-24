SELECT 
    c.clientID,
    c.name,
    c.typeOfService as type,
    IF(c.invoiceDue = '0000-00-00 00:00:00',
        '',
        invoiceDue) as invoiceDue,
    IF(c.invoiceDUE = '0000-00-00 00:00:00',
        '',
        DATEDIFF(invoiceDUE, NOW())) as daysUntilDue,
    (SELECT 
            followers
        FROM
            DataTwitter
        WHERE
            clientID = c.clientID
                AND createdOnDate BETWEEN date_ADD(date_sub(CURDATE(), INTERVAL 1 DAY),
                INTERVAL 0 HOUR) AND date_ADD(date_sub(CURDATE(),
                    INTERVAL '0:1' DAY_SECOND),
                INTERVAL 0 HOUR)
        ORDER BY createdOnDate DESC
        LIMIT 0 , 1) as tyf,
    (SELECT 
            followers
        FROM
            DataTwitter
        WHERE
            clientID = c.clientID
                AND createdOnDate BETWEEN date_ADD(date_sub(CURDATE(), INTERVAL 2 DAY),
                INTERVAL 0 HOUR) AND date_ADD(date_sub(CURDATE(),
                    INTERVAL '1 0:0:1' DAY_SECOND),
                INTERVAL 0 HOUR)
        ORDER BY createdOnDate DESC
        LIMIT 0 , 1) as tdbyf,
    (SELECT 
            totalPageLikes
        FROM
            DataFacebook
        WHERE
            clientID = c.clientID
                AND createdOnDate BETWEEN date_ADD(date_sub(CURDATE(), INTERVAL 1 DAY),
                INTERVAL 0 HOUR) AND date_ADD(date_sub(CURDATE(),
                    INTERVAL '0:1' DAY_SECOND),
                INTERVAL 0 HOUR)
        ORDER BY createdOnDate DESC
        LIMIT 0 , 1) as fyf,
    (SELECT 
            totalPageLikes
        FROM
            DataFacebook
        WHERE
            clientID = c.clientID
                AND createdOnDate BETWEEN date_ADD(date_sub(CURDATE(), INTERVAL 2 DAY),
                INTERVAL 0 HOUR) AND date_ADD(date_sub(CURDATE(),
                    INTERVAL '1 0:0:1' DAY_SECOND),
                INTERVAL 0 HOUR)
        ORDER BY createdOnDate DESC
        LIMIT 0 , 1) as fdbyf
FROM
    Clients c
ORDER BY invoiceDUE ASC