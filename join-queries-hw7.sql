/* 2233732 YEŞİM KUMBARACI HW7 */
USE `happypaws`;
								/* QUERY 1 */
-- if initial stock is asked --
SELECT distinct product.ProductID, product.ProductName, product.UnitsinStock, sum(saleitem.Quantity) as TotalQuantitySold from 
product LEFT JOIN saleitem on product.ProductID = saleitem.ProductID 
group by saleitem.ProductID order by TotalQuantitySold desc limit 10;

-- if final stock is asked --
SELECT distinct product.ProductID, product.ProductName,  sum(saleitem.Quantity) as TotalQuantitySold, 
product.UnitsinStock -sum(saleitem.Quantity) as LeftinStock from 
product LEFT JOIN saleitem on product.ProductID = saleitem.ProductID 
group by saleitem.ProductID order by TotalQuantitySold desc limit 10;

								/* QUERY 2 */

select sale.SaleID, sale.SaleDate, owners.OwnerName, owners.email  FROM sale 
INNER JOIN owners ON sale.CustomerID = owners.OwnerID group by OwnerID order by sale.SaleDate asc ;

								/* QUERY 3 */

select  OwnerName, sum(pets.HourlyFee*WalkDuration/60)  as TotalAmount from owners 
LEFT JOIN pets on pets.OwnerID = owners.OwnerID
LEFT JOIN walkerschedule as ws on pets.PetID = ws.PetID
group by owners.OwnerID
order by TotalAmount desc ;

							/* QUERY 4 */
                            
-- NULL ONES ARE NULL BECAUSE THEY ARE LAST 8 PETS ADDED TO DATABASE 
SELECT  pets.PetName, sum(WalkDuration/60) as TotalWalkDuration from pets 
LEFT JOIN walkerschedule AS ws ON pets.PetID = ws.PetID 
group by pets.PetID
order by TotalWalkDuration desc ;


