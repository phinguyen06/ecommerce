package com.ebiz.cache;



/**

 * This class takes care of doing most of the common loading of data, as

 * well as provides an interface to make data providers loadable, and

 * clearable extending this class is simple, just implement load(), clear(),

 * and addRow, to do implementation specific storage of the read data

 *

 * Requires children to allocate the Trace object specific to their name to m_trace

 */



public abstract class DataProvider implements IReload
{

   protected synchronized void register() throws Exception
   {
      DataProviderController.register(this);
   }

   /**
    *   called on subclasses during load to remove
    */
   public abstract void clear();

   /**
    * generic load called externally implements Reloadable
    */
   public abstract void load() throws Exception;



}

