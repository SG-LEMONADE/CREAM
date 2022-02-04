import styled from "@emotion/styled";
import ShortcutItem from "components/atoms/ShortcutItem";
import React, { FunctionComponent } from "react";
import { ShortcutItemRes } from "types";

type ShortcutsProps = {
	items?: ShortcutItemRes[];
};

const Shortcuts: FunctionComponent<ShortcutsProps> = (props) => {
	const { items } = props;
	return (
		<StyledShortcutWrapper>
			{items ? (
				items.map((item) => (
					<ShortcutItem
						link={item.link}
						bigImgSrc={item.bigImg}
						smallImgSrc={item.smallImg}
						title={item.title}
					/>
				))
			) : (
				<>
					<ShortcutItem
						link={"/"}
						bigImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfODIg/MDAxNjQyMTU4OTI4NTMw.7_sAnOgUFxUyKVkQgepQp2DWk8pVXpm_xl7LJqAEz1og.7SLCSPjC2IQL4t1trFDzAk3mNvxxYD30jdWVCPIcQmQg.GIF/a_248a7191e7d042e98446f5d2e4fe0c07.gif?type=m"
						smallImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfNTIg/MDAxNjQyMTU4OTI2MTk1.H8metHzQAOn4bO8PKtj8n1bHEl_Hqrgm5AMdlQqzfg0g.F56SpTs1-xFXWZuv8cBKk7QNlT-EqljWFjQQFO3Gofog.GIF/a_e5864b84421c452f86d0292f134e2beb.gif"
						title="프리미엄"
					/>
					<ShortcutItem
						link={"/"}
						bigImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfNjUg/MDAxNjQyMTU5MDU3NjQ0.6UT2n2TIBXaZrTsANX0jzD5MnAlhGFJoa_1hUk9LuJQg.zgj4FNXPburxIqL7FNfXqoakZwwiYZFZl67ThkiIPxgg.JPEG/a_390f944c3af843598e9e7a887ec1d4ad.jpg?type=m"
						smallImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTA1/MDAxNjQyMTU5MDU2NDg0.-6iw5D262sfoHyHNjkkz5hfp4Ovn3u_H7zKuvkK5A4og.VY1HNbpQiYeJAb428J6a2CDv3wyUPsifQZO38GOdS-8g.JPEG/a_cb9afbc55d6a46139610fbb315582c8b.jpg"
						title="겨울 아우터"
					/>
					<ShortcutItem
						link={"/"}
						bigImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMjE1/MDAxNjQyMTU5MDkzMTA5.jYkIpHR1COueflqCn8Yw55IAHUqU5RldYcwvdOMqfiQg.l21Ywj_7dr7jBm0le5abUnD_Linotl-nFlnHuJ-QK9sg.JPEG/a_3c5bbf01cda2437d9c3d3576f817b22c.jpg?type=m"
						smallImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTI1/MDAxNjQyMTU5MDg5OTQ4.wb_R_ivuGIcBHgkkheeuggLIEqeepfuFsW9y5vE4E6og.xKR1HnzYOQ89LIb7QZkOAKGAIdBJO7a95gM0NBxra4Ug.JPEG/a_634f051baf754c59bb1f608b63e7a03c.jpg"
						title="#스타일"
					/>
					<ShortcutItem
						link={"/"}
						bigImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMjhfMTQw/MDAxNjQzMzQwNDkzMjg3.8_2MetaVZa3nN2nXsY12HYJh-99WsrTz4I2Rh8WdCrcg.o5JC2XBdtKQMxsT-qMt8LaTllyYkQyllXBNJ-9AUroog.JPEG/a_7dabc4d43517452bb817a040197b0033.jpg?type=m"
						smallImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTc5/MDAxNjQyMTU5MTY0NjAy.meJovZOpmReE3OMln2KOQWNECkhWRpBfkFLL2_gqrm8g.4Z96Qs3T1khnZiv2JLAQFmWkY46j6fION-uXwkJqURIg.JPEG/a_2f4743870ed3490591e19767ee6a8411.jpg"
						title="럭키 드로우"
					/>
					<ShortcutItem
						link={"/"}
						bigImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTQz/MDAxNjQyMTU5MjAzMTky.gBmTPr0MuTH3Gb-lzKETZZeR5mL4N0wrNMxPYYsFWPMg.iw9vitAc87EJMgJyYAueUKUMtMW8Vz4lhg_LfMXYUecg.JPEG/a_8118c64019764004be4134ea4c03f1f2.jpg?type=m"
						smallImgSrc="https://kream-phinf.pstatic.net/MjAyMjAxMTRfMTYz/MDAxNjQyMTU5MjAwMjg2.ew8Fdr7PqkMvzi9MOphqSHy4UvcDn5-GtZzYR4lYmN8g.R5HPRfKcHrNeMmL87gVilTJRZ-HyPrXBeNl5DepofHwg.JPEG/a_5d9605f7d8dc4512bf419672973ca0c1.jpg"
						title="빠른 배송"
					/>
				</>
			)}
		</StyledShortcutWrapper>
	);
};

export default Shortcuts;

const StyledShortcutWrapper = styled.section`
	margin: 20px auto 0;
	max-width: 1280px;
	padding: 0 0 20px;
	@media screen and (max-width: 1200px) {
		text-align: center;
		padding: 0 100px 20px;
		display: flex;
		justify-content: space-around;
	}
`;
