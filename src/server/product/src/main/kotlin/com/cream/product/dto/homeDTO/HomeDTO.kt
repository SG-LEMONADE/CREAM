package com.cream.product.dto.homeDTO

import org.springframework.boot.Banner

data class HomeDTO (
    val adImageUrls: List<String>,
    val sections: List<SectionDTO>
)