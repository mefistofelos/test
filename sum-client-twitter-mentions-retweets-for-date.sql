SELECT 
    SUM(mentions) as mentions, SUM(retweets) as retweets
FROM
    jadensocial_crmV2.DataTwitter
where
    createdOnDate >= '2013-11-12 00:00:00'
        AND createdOnDate <= '2013-11-18 23:59:59'
        AND clientID = 40