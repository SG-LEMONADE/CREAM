import React, { FunctionComponent, useState } from "react";
import useSWR from "swr";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import TradeDetail, { StyledH3 } from "components/organisms/TradeDetail";
import { fetcher } from "lib/fetcher";
import { TradeHistoryRes } from "types";

const MyTradeBuying: FunctionComponent = () => {
	const [filter, setFilter] = useState<string>("WAITING");

	const { data: TradeInfo } = useSWR<TradeHistoryRes>(
		`${process.env.END_POINT_PRODUCT}/trades?cursor=0&perPage=10&requestType=ASK&tradeStatus=${filter}`,
		fetcher,
	);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<MyPageTemplate>
				<StyledH3>구매 내역</StyledH3>
				{TradeInfo && (
					<TradeDetail
						category="buy"
						waiting={TradeInfo.counter.waitingCnt}
						in_progress={TradeInfo.counter.inProgressCnt}
						finished={TradeInfo.counter.finishedCnt}
						filter={filter}
						onClick={setFilter}
						// FIX ME
						// items={TradeInfo.trades}
						items={[]}
					/>
				)}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyTradeBuying;
