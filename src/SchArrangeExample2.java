import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SchArrangeExample2 {
	
	//将NUM设置为待排列数组的长度即实现全排列
	private static int NUM = 10;

	public static void main(String[] args) {
		String deptArray [] = {"A0","A1","A2","A3","A4","A5","A6","A7","A8","A9"}; 
		List<String> deptList = Arrays.asList(deptArray);
		int deptStepArray [] = {3,3,3,1,1,1,1,1,1,2}; 
		int maxSetp = 17;
		sort(Arrays.asList(deptArray), new ArrayList());
		
	}
	
	private static void sort(List datas, List target) {
		if (target.size() == NUM) {
			for (Object obj : target)
				System.out.print(obj+",");
			System.out.println();
			return;
		}
		for (int i = 0; i < datas.size(); i++) {
			List newDatas = new ArrayList(datas);
			List newTarget = new ArrayList(target);
			newTarget.add(newDatas.get(i));
			newDatas.remove(i);
			sort(newDatas, newTarget);
		}
	}
	
	private static void _printArray(double[][] intArray){
		for(double ttt [] : intArray){
			for(double t : ttt){
				System.err.print(t+",");
			}
			System.err.println("");
		}
		System.err.println("------------------------------------");
	}

}
