-- VARIANTES

-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).

SELECT * FROM producto WHERE precio = 559;