package com.cream.product.model

import com.cream.product.converter.RequestTypeConverter
import com.cream.product.converter.TradeStatusConverter
import com.cream.product.constant.RequestType
import com.cream.product.constant.TradeStatus
import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "trade")
class Trade(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) var id: Long? = null,
    @Column var userId: Long,
    @ManyToOne @JoinColumn(name = "product_id") var product: Product,
    @Column var size: String,
    @Convert(converter = RequestTypeConverter::class) @Column var requestType: RequestType, // 0-bid(판매 요청), 1-ask(구매 요청)
    @Convert(converter = TradeStatusConverter::class) @Column var tradeStatus: TradeStatus, // 0-등록된 상태, 1-거래 진행중, 2-거래 완료
    @Column var price: Int,
    @Column var validationDateTime: LocalDateTime,
    @Column var counterpartUserId: Long? = null,
    @Column var createdAt: LocalDateTime = LocalDateTime.now(),
    @Column var updatedAt: LocalDateTime? = null
)