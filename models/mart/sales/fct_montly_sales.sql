{{ config( tags=['dash_sales_bi'] )}}

SELECT 
    DDATE,
    ID_SALESPERSON,
    ID_CARMAKE,
    TOTALSALE,
    TOTALCOM
FROM
{{ref("psg_montly_sales_make")}} AS psgm
LEFT JOIN {{ ref("dim_carmake")}} AS dimcm ON psgm.CARMAKE = dimcm.CARMAKE
LEFT JOIN {{ ref("dim_salesperson")}} AS dimsp ON psgm.SALESPERSON = dimsp.SALESPERSON
