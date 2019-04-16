package com.ebiz.cache;

import java.util.Set;

import java.util.Iterator;

import java.util.HashMap;

import java.util.Date;

public final class DataProviderController {

	private static HashMap s_reloadables = new HashMap();

	private static HashMap s_reloadTimes = new HashMap();

	/**
	 * 
	 * register - Registering this data provider in current JVM
	 * 
	 * 
	 * 
	 * @param reloadMe
	 */

	public static void register(IReload reloadMe)

	{

		s_reloadables.put(reloadMe.getClass().getName(), reloadMe);

		s_reloadTimes.put(reloadMe.getClass().getName(), new Date());

	}

	/**
	 * 
	 * getNames - Return all data provider names currently loaded in JVM
	 * 
	 * 
	 * 
	 * @return String[]
	 */

	public synchronized static String[] getNames()

	{

		String[] rets = new String[s_reloadables.size()];

		int i = 0;

		Set set = s_reloadables.keySet();

		for (Iterator iter = set.iterator(); iter.hasNext();)

		{

			rets[i++] = (String) iter.next();

		}

		return rets;

	}

	/**
	 * 
	 * getReloadTime - Return date stamp when this data provider loaded
	 * 
	 * 
	 * 
	 * @param name
	 *            Name of data provider
	 * 
	 * @return Date
	 * 
	 * @see Date
	 */

	public synchronized static Date getReloadTime(String name)

	{

		return (Date) s_reloadTimes.get(name);

	}

	/**
	 * 
	 * getReloadTime - Return date stamp for all data providers
	 * 
	 * 
	 * 
	 * @return Date[]
	 * 
	 * @see Date
	 */

	public synchronized static Date[] getReloadTimes()

	{

		Date[] rets = new Date[s_reloadTimes.size()];

		int i = 0;

		Set set = s_reloadTimes.keySet();

		for (Iterator iter = set.iterator(); iter.hasNext();)

		{

			rets[i++] = (Date) s_reloadTimes.get(iter.next());

		}

		return rets;

	}

	/**
	 * 
	 * reload - Reload this data provider
	 * 
	 * 
	 * 
	 * @param name
	 * 
	 * @return boolean Succefull reload or not
	 */

	public synchronized static boolean reload(String name)

	{

		IReload r = (IReload) s_reloadables.get(name);

		if (r != null) {

			try {

				r.load();

				// Trace.logDebug("DataProviderController::reload", "reloaded "
				// + name);

				return true;

			}

			catch (Exception e) {

				// Trace.logException("DataProviderController::reload", e);

				return false;

			}

		}

		return true;

	}

	/**
	 * 
	 * reload - Reload all data provider
	 * 
	 * 
	 * 
	 * @return boolean Succefull reload or not
	 */

	public synchronized static boolean reload()

	{

		boolean noErrors = true;

		Set set = s_reloadables.entrySet();

		for (Iterator iter = set.iterator(); iter.hasNext();) {

			Object name = iter.next();

			IReload r = (IReload) s_reloadables.get(name);

			if (r != null) {

				try {

					r.load();

					// Trace.logDebug("DataProviderController::reload",
					// "reloaded " + name);

				}

				catch (Exception e) {

					// Trace.logException("DataProviderController::reload", e);

					noErrors = false;

				}

			}

		}

		return noErrors;

	}

}
