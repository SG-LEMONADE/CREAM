package com.cream.product.persistence

import com.cream.product.model.Trade
import org.springframework.data.jpa.repository.JpaRepository

interface TradeRepository : JpaRepository<Trade, Long>