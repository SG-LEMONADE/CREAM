import React, { FunctionComponent } from "react";
import useSWR from "swr";
import { fetcher, fetcherWithToken } from "lib/fetcher";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import UserMemberShip from "components/organisms/UserMembership";
import TradeHistory from "components/organisms/TradeHistory";
import { UserInfo, TradeHistoryRes } from "types";

const MyPage: FunctionComponent = () => {
	const { data: userData } = useSWR<UserInfo>(
		`${process.env.END_POINT_USER}/users/me`,
		fetcherWithToken,
	);

	const { data: askHistory } = useSWR<TradeHistoryRes>(
		`${process.env.END_POINT_PRODUCT}/trades?cursor=0&perPage=5&requestType=ASK&tradeStatus=ALL`,
		fetcher,
	);

	const { data: bidHistory } = useSWR<TradeHistoryRes>(
		`${process.env.END_POINT_PRODUCT}/trades?cursor=0&perPage=5&requestType=BID&tradeStatus=ALL`,
		fetcher,
	);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<MyPageTemplate>
				{userData && (
					<UserMemberShip
						imgSrc={userData.profileImageUrl}
						userName={userData.name}
						userEmail={userData.email}
					/>
				)}
				{askHistory && (
					<TradeHistory
						category="buy"
						total={askHistory.counter.totalCnt}
						waiting={askHistory.counter.waitingCnt}
						pending={askHistory.counter.inProgressCnt}
						over={askHistory.counter.finishedCnt}
						items={askHistory.trades}
					/>
				)}
				{bidHistory && (
					<TradeHistory
						category="buy"
						total={bidHistory.counter.totalCnt}
						waiting={bidHistory.counter.waitingCnt}
						pending={bidHistory.counter.inProgressCnt}
						over={bidHistory.counter.finishedCnt}
						items={bidHistory.trades}
					/>
				)}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyPage;
