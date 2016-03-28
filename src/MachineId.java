import com.pinde.core.license.PdLicense;


public class MachineId {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.err.println(PdLicense.getMachineId());
		String t = "(&#23567;&#20110;&lt;50mL)";
		System.err.println(t.replaceAll("&lt;", "¡´"));
	}
}
