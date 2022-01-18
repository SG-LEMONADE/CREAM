package com.cream.product.model

import com.fasterxml.jackson.annotation.JsonIgnore
import javax.persistence.*

@Entity
@Table(name="market")
class MarketEntity (
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name="id") var id: Long? = null,
    @JsonIgnore @ManyToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY) @JoinColumn(name="product_id") var product: ProductEntity,
    @Column(name="size") var size: String,
    @Column(name="change_percentage") var changePercentage: Float,
    @Column(name="change_value") var changeValue: Int,
    @Column(name="highest_bid") var highestBid: Int,
    @Column(name="last_sale_price") var lastSalePrice: Int,
    @Column(name="lowest_ask") var lowestAsk: Int,
    @Column(name="price_premium") var pricePremium: Int,
    @Column(name="price_premium_percentage") var pricePremiumPercentage: Float,
    @Column(name="total_sales") var totalSales: Int
    )