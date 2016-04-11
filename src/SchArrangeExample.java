import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.iterators.PermutationIterator;

import com.pinde.core.util.StatisticsUtil;

public class SchArrangeExample {

	public static void main(String[] args) {
		String deptArray [] = {"A0","A1","A2","A3","A4","A5","A6","A7","A8","A9"}; 

		Map<String,Integer> indexMap = new HashMap<String,Integer>();
		indexMap.put("A0", 0);
		indexMap.put("A1", 1);
		indexMap.put("A2", 2);
		indexMap.put("A3", 3);
		indexMap.put("A4", 4);
		indexMap.put("A5", 5);
		indexMap.put("A6", 6);
		indexMap.put("A7", 7);
		indexMap.put("A8", 8);
		indexMap.put("A9", 9);
		
		Map<String,Integer> stepMap = new HashMap<String,Integer>();
		stepMap.put("A0", 3);
		stepMap.put("A1", 3);
		stepMap.put("A2", 3);
		stepMap.put("A3", 1);
		stepMap.put("A4", 1);
		stepMap.put("A5", 1);
		stepMap.put("A6", 1);
		stepMap.put("A7", 1);
		stepMap.put("A8", 1);
		stepMap.put("A9", 2);
		
		
		int maxSetp = 17;
		
		double[][] old = new double[deptArray.length][maxSetp];
		for(int i=0;i<deptArray.length;i++){
			for(int j=0;j<maxSetp;j++){
				old[i][j] = 0;
			}
		}

//		_printArray(old);
		
		int doctorNum = 100;
		double [] doctor = new double[doctorNum]; 
		for(int d=0;d<doctorNum;d++){
			doctor[d] = Double.MAX_VALUE;
		}
		
		List<List<String>> permutationSchDeptFlowList = new LinkedList<List<String>>();
		List<String> deptList = Arrays.asList(deptArray);
		Iterator<List<String>> it = new PermutationIterator<String>(deptList);
		while (it.hasNext()) {
			List<String> schDeptFlowArray = it.next();
			permutationSchDeptFlowList.add(schDeptFlowArray);
		}
		int doctorStep = 1;
		for(int d=0;d<doctorNum;d++){
			double doctorIndex = Double.MAX_VALUE;
			int bestOrder = 0;
			List<String> bestSchDeptFlowArray = null;
			int order = 0;
			long start = System.currentTimeMillis();
			for(List<String> schDeptFlowArray : permutationSchDeptFlowList){
				//初始化
				double[][] newArray = _copyArray(old);
	
				int totalStep = 0;
				for(int i=0;i<schDeptFlowArray.size();i++){
					String schDeptFlow = schDeptFlowArray.get(i);
					int oriIndex = indexMap.get(schDeptFlow);
					int step = stepMap.get(schDeptFlow);
					for(int s=0;s<step;s++){
						newArray[oriIndex][totalStep+s] += doctorStep;
					}
					totalStep += step;
				}
//				_printArray(newArray);
				double index = StatisticsUtil.arrange(newArray);
				if(index<doctorIndex){
					bestOrder = order;
					doctorIndex = index;
					bestSchDeptFlowArray = schDeptFlowArray;
				}
				double oldIndex = StatisticsUtil.arrange(old);
				if(oldIndex==0d){
					System.err.println("0 found:"+order);
					break;
				}
//				if(index<StatisticsUtil.getMin(doctor)){
//					System.err.println("min found:"+order);
//					break;
//				}
				order++;
			}
			
			//最佳方案
			int totalStep = 0;
			for(int i=0;i<bestSchDeptFlowArray.size();i++){
				String schDeptFlow = bestSchDeptFlowArray.get(i);
				int oriIndex = indexMap.get(schDeptFlow);
				int step = stepMap.get(schDeptFlow);
				for(int s=0;s<step;s++){
					old[oriIndex][totalStep+s] += doctorStep;
				}
				totalStep += step;
				System.err.print(schDeptFlow+" ");
			}
			System.err.println();
//			_printArray(old);
			double index = StatisticsUtil.arrange(old);
			doctor[d] = index;
			long end = System.currentTimeMillis();
			System.err.println("doctor"+(d+1)+": "+bestOrder+" index:"+index+",times eslape:"+(end-start));
		}
	}
	
	private static double[][] _copyArray(double[][] strArray){
		double[][] copyArray=new double[strArray.length][];
		for(int i=0;i<strArray.length;i++){
			copyArray[i]=new double[strArray[i].length];
			System.arraycopy(strArray[i], 0, copyArray[i], 0, strArray[i].length);
		}
		return copyArray;
	}
	
	private static void _printArray(double[][] intArray){
//		for(double ttt [] : intArray){
//			for(double t : ttt){
//				System.err.print(t+",");
//			}
//			System.err.println("");
//		}
		System.err.println("------------------------------------");
	}

}
