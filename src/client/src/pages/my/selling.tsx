import React, {
	FunctionComponent,
	useState,
	useCallback,
	useEffect,
} from "react";
import useSWR from "swr";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import TradeDetail, { StyledH3 } from "components/organisms/TradeDetail";
import { fetcher } from "lib/fetcher";
import { TradeHistoryRes } from "types";

import Pagination from "rc-pagination";
import "rc-pagination/assets/index.css";

const MyTradeBuying: FunctionComponent = () => {
	const [cursor, setCursor] = useState<number>(0);
	const [filter, setFilter] = useState<string>("WAITING");

	const { data: TradeInfo } = useSWR<TradeHistoryRes>(
		`${process.env.END_POINT_PRODUCT}/trades?cursor=0&perPage=10&requestType=BID&tradeStatus=${filter}`,
		fetcher,
	);

	const onHandleChange = useCallback(
		(current: number, pageSize: number) => {
			setCursor(current - 1);
		},
		[setCursor],
	);

	useEffect(() => {
		setCursor(0);
	}, [filter]);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<MyPageTemplate>
				<StyledH3>판매 내역</StyledH3>
				{TradeInfo && (
					<TradeDetail
						category="sell"
						waiting={TradeInfo.counter.waitingCnt}
						in_progress={TradeInfo.counter.inProgressCnt}
						finished={TradeInfo.counter.finishedCnt}
						filter={filter}
						onClick={setFilter}
						items={TradeInfo.trades}
					/>
				)}
				{TradeInfo && (
					<Pagination
						defaultPageSize={10}
						total={TradeInfo.counter.totalCnt}
						current={cursor + 1}
						onChange={onHandleChange}
						style={{ textAlign: "center", marginTop: "40px" }}
					/>
				)}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyTradeBuying;
