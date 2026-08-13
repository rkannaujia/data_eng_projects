-- edw_prod_dbo.inv_material_transaction_usage_v source

CREATE OR REPLACE VIEW edw_prod_dbo.inv_material_transaction_usage_v
AS WITH usage AS (
         SELECT w.inventory_item_id,
            w.organization_id,
            w.subinventory_code,
            w.locator_id,
            sum(
                CASE
                    WHEN w.transaction_date >= (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) - '1 mon'::interval) AND w.transaction_date < date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) AND (w.transaction_action_id = 1 AND (w.transaction_source_type_id = ANY (ARRAY[2::bigint, 5::bigint, 8::bigint, 13::bigint])) OR w.transaction_action_id = 3 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 21 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 27 AND w.transaction_source_type_id = 5) THEN COALESCE(- w.transaction_quantity, 0::double precision)
                    ELSE 0::double precision
                END) AS usage_1_month,
            sum(
                CASE
                    WHEN w.transaction_date >= (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) - '3 mons'::interval) AND w.transaction_date < date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) AND (w.transaction_action_id = 1 AND (w.transaction_source_type_id = ANY (ARRAY[2::bigint, 5::bigint, 8::bigint, 13::bigint])) OR w.transaction_action_id = 3 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 21 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 27 AND w.transaction_source_type_id = 5) THEN COALESCE(- w.transaction_quantity, 0::double precision)
                    ELSE 0::double precision
                END) AS usage_3_month,
            sum(
                CASE
                    WHEN w.transaction_date >= (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) - '6 mons'::interval) AND w.transaction_date < date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) AND (w.transaction_action_id = 1 AND (w.transaction_source_type_id = ANY (ARRAY[2::bigint, 5::bigint, 8::bigint, 13::bigint])) OR w.transaction_action_id = 3 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 21 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 27 AND w.transaction_source_type_id = 5) THEN COALESCE(- w.transaction_quantity, 0::double precision)
                    ELSE 0::double precision
                END) AS usage_6_month,
            sum(
                CASE
                    WHEN w.transaction_date >= (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) - '1 year'::interval) AND w.transaction_date < date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) AND (w.transaction_action_id = 1 AND (w.transaction_source_type_id = ANY (ARRAY[2::bigint, 5::bigint, 8::bigint, 13::bigint])) OR w.transaction_action_id = 3 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 21 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 27 AND w.transaction_source_type_id = 5) THEN COALESCE(- w.transaction_quantity, 0::double precision)
                    ELSE 0::double precision
                END) AS usage_12_month,
            sum(
                CASE
                    WHEN w.transaction_date >= (date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) - '2 years'::interval) AND w.transaction_date < date_trunc('month'::text, CURRENT_DATE::timestamp with time zone) AND (w.transaction_action_id = 1 AND (w.transaction_source_type_id = ANY (ARRAY[2::bigint, 5::bigint, 8::bigint, 13::bigint])) OR w.transaction_action_id = 3 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 21 AND w.transaction_source_type_id = 8 OR w.transaction_action_id = 27 AND w.transaction_source_type_id = 5) THEN COALESCE(- w.transaction_quantity, 0::double precision)
                    ELSE 0::double precision
                END) AS usage_24_month
           FROM edw_prod_dbo.w_inv_material_transactions_d w
          GROUP BY w.inventory_item_id, w.organization_id, w.subinventory_code, w.locator_id
        )
 SELECT imt.source_system,
    imt.transaction_id,
    imt.transaction_date,
    imt.transaction_source_type_name,
    imt.transaction_type_name,
    imt.bu_name,
    imt.organization_code,
    imt.item_number,
    imt.description,
    imt.product_family,
    imt.product_line,
    imt.product_model,
    imt.commodity_class,
    imt.sourcing_segment,
    imt.subinventory_code,
    imt.item_standard_cost,
    imt.item_standard_cost_usd,
    imt.material_cost,
    imt.material_cost_usd,
    imt.resource_cost,
    imt.resource_cost_usd,
    imt.overhead_cost,
    imt.overhead_cost_usd,
    imt.outside_processing_cost,
    imt.outside_processing_cost_usd,
    imt.extended_cost,
    imt.extended_cost_usd,
    u.usage_1_month,
    u.usage_3_month,
    u.usage_6_month,
    u.usage_12_month,
    u.usage_24_month,
    imt.buyer_name,
    imt.inventory_planning_code,
    imt.make_buy,
    imt.serial_number,
    imt.transaction_quantity,
    imt.transaction_uom,
    imt.primary_quantity,
    imt.transfer_organization_code,
    imt.shipment_number,
    imt.so_order_number,
    imt.so_line_number,
    imt.customer_name,
    imt.wo_number,
    imt.wo_type,
    imt.wo_completion_date,
    imt.creation_date,
    imt.created_by
   FROM edw_prod_dbo.w_inv_material_transactions_d imt
     JOIN usage u ON imt.inventory_item_id = u.inventory_item_id AND imt.organization_id = u.organization_id AND imt.subinventory_code::text = u.subinventory_code::text AND imt.locator_id = u.locator_id
  WHERE imt.transaction_date >= '2025-01-01 00:00:00'::timestamp without time zone;